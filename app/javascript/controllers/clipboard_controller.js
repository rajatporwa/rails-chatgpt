// app/javascript/controllers/clipboard_controller.js
import { Controller } from "stimulus"

export default class extends Controller {
  copy(event) {
    event.preventDefault();
    const source = this.element.querySelector('[data-clipboard-target="source"]');
    const textToCopy = source.value;

    navigator.clipboard.writeText(textToCopy).then(function() {
      console.log('Text copied to clipboard');
    }, function(err) {
      console.error('Failed to copy text: ', err);
    });
  }
}
