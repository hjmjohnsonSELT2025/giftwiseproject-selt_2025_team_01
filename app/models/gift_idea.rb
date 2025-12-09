class GiftIdea < ApplicationRecord
  belongs_to :recipient

  validates :title, presence: true
  validate :url_must_be_valid, if: -> { url.present? }

  before_save :normalize_url, if: -> { url.present? }

  private

  def url_must_be_valid
    return if url.blank?

    begin
      uri = URI.parse(url)

      # Check it's HTTP or HTTPS
      unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
        errors.add(:url, "must be a valid HTTP or HTTPS URL")
        return
      end

      # Check host exists and has at least one dot (for TLD)
      unless uri.host.present? && uri.host.include?('.') && uri.host.split('.').length >= 2
        errors.add(:url, "must have a valid domain name (e.g., amazon.com)")
        return
      end

      # Check that the TLD is at least 2 characters
      tld = uri.host.split('.').last
      unless tld && tld.length >= 2
        errors.add(:url, "must have a valid top-level domain")
      end

    rescue URI::InvalidURIError
      errors.add(:url, "is not a valid URL format")
    end
  end

  def normalize_url
    self.url = url.strip
    self.url = "https://#{self.url}" unless self.url.match?(/\Ahttps?:\/\//i)
  end

end
