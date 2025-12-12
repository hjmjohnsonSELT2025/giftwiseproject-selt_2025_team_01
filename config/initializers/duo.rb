require "duo_web"

if Rails.env.production?
  DUO = {
    "DUO_IKEY" => ENV["DUO_IKEY"],
    "DUO_SKEY" => ENV["DUO_SKEY"],
    "DUO_HOST" => ENV["DUO_HOST"],
    "DUO_AKEY" => ENV["DUO_AKEY"]
  }
else
  duo_config_path = Rails.root.join("config", "duo_cred.yml")

  if File.exist?(duo_config_path)
    DUO = YAML.load_file(duo_config_path)
  else
    Rails.logger.warn "[DUO] config/duo_cred.yml not found – Duo 2FA disabled"
    DUO = {}
  end
end
