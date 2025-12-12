import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    // Define targets to easily access the form fields
    static targets = ["title", "notes", "url", "generateButtonEvent"]

    // This method will be called when the button is clicked
    async generateSuggestionEvent(event) {
        event.preventDefault(); // Stop the form from submitting

        const button = this.generateButtonEventTarget;
        button.disabled = true;
        button.textContent = "Generating...";

        // Infer the URL structure from the form action
        const actionUrl = this.element.action;
        const parts = actionUrl.split('/');
        // Assumes URL is /recipients/:recipient_id/gift_ideas or similar
        const eventID = parts[parts.length - 4];
        const recipientId = parts[parts.length - 2];
        const suggestUrl = `/events/${eventID}/recipients/${recipientId}/gift_ideas/suggest`;

        try {
            const response = await fetch(suggestUrl, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
                }
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const suggestion = await response.json();
            // Update the targets
            this.titleTarget.value = suggestion.title || '';
            this.notesTarget.value = suggestion.notes || '';
            this.urlTarget.value = suggestion.url || '';

        } catch (error) {
            console.error("AI suggestion error:", error);
            alert("Error generating AI suggestion. Please check the console.");
        } finally {
            button.disabled = false;
            button.textContent = "AI Gift Idea";
        }
    }
}