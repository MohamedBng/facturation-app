import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "fieldContain"]
  static values = { "fieldClass" : String }
  static globalIndex = 0;

  addField(e) {
    e.preventDefault();

    this.buildNewAssociation(e);
    this.constructor.globalIndex++;

    this.element.dispatchEvent(new CustomEvent('item-added', { bubbles: true }));
  }

  removeField(e) {
    e.preventDefault();
    const wrapperField = this.hasFieldClassValue ? e.target.closest("." + this.fieldClassValue) : e.target.parentNode;

    if (e.target.matches('.dynamic')) {
      wrapperField.remove();
      console.log('removed');
    } else {
      console.log('marked for deletion');
      wrapperField.querySelector("input[name*='_destroy']").value = 1;
      wrapperField.style.display = "none";
    }
  }

  buildNewAssociation(element) {
    const assoc = element.target.dataset.association;
    const assocs = element.target.dataset.associations;
    const content = this.templateTarget.innerHTML;

    let regexpBraced = new RegExp('\\[new_' + assoc + '\\](.*?\\s)', 'g');
    let newId = new Date().getTime();
    let newContent = content.replace(regexpBraced, '[' + newId + ']$1');

    if (newContent === content) {
      regexpBraced = new RegExp('\\[new_' + assocs + '\\](.*?\\s)', 'g');
      newContent = content.replace(regexpBraced, '[' + newId + ']$1');
      this.initializeTrixEditor(newId);
    }

    this.fieldContainTarget.insertAdjacentHTML('beforeend', newContent);

    this.initializeTrixEditor(newId);
  }

  initializeTrixEditor(newIndex) {
    const trixEditors = this.fieldContainTarget.querySelectorAll("trix-editor");

    if (trixEditors.length > 0) {
      const lastTrixEditor = trixEditors[trixEditors.length - 1];

      const id = lastTrixEditor.editor.element.id;

      console.log(id);

      if (id.endsWith("devi_items_attributes_new_items_detail")) {

        const newId = lastTrixEditor.editor.element.id.replace("new_items", newIndex);

        const hiddenInputId = lastTrixEditor.getAttribute("input");
        lastTrixEditor.editor.element.setAttribute("id", newId);
        lastTrixEditor.editor.element.setAttribute("input", `devi_items_attributes_${newIndex}_detail_trix_input_item`);

        const hiddenInput = document.getElementById(hiddenInputId);
        hiddenInput.name = `devi[items_attributes][${newIndex}][detail]`;
        hiddenInput.id = `devi_items_attributes_${newIndex}_detail_trix_input_item`;
      }
    };
  }
}
