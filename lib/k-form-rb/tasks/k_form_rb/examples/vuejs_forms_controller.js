import { Controller } from "stimulus"
import { FormStore } from 'k-form-js'

// OPTIONAL: import a custom vuex plugin that allows adding additional behaviour
// import plugin from 'path/to/plugin'

// OPTIONAL: use custom components
// import CustomComponent from 'path/to/plugin'

export default class extends Controller {
  connect() {
    const serializedValues = this.element.dataset.values || "{}";
    const validationUrl = this.element.dataset.validationUrl
    let values = JSON.parse(serializedValues);
    let authenticityToken = this.element.querySelector("input[name='authenticity_token']").value

    const app = new FormStore({
      authenticityToken: authenticityToken,
      additionalComponents: {
        // 'x-custom_component': CustomComponent
      }, // optional
      plugins:[
        // plugin
      ],  // optional
      element: this.element.firstElementChild,
      validationUrl: validationUrl,
      values: values,
    }).app
  }
}