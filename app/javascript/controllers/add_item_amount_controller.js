import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ["amounts", "form"]

  // connect() {
  //   console.log(this.element)
  //   console.log(this.amountsTarget)
  //   console.log(this.formTarget)
  // }

  send(event) {
    event.preventDefault();

    // FETCH SAMPLE STRUCTURE
    // fetch(url, options)
    //   .then(response => response.text())
    //   .then(data => {
    //     console.log(data);
    //   })

    const url = this.formTarget.action;
    // this -> this controller, formTarget -> syntax to access the defined targets on the page, action -> accessing the action attribute of the selected element on the page

    fetch(url, {
      method: "POST",
      headers: { "Accept": 'application/json', "X-CSRF-Token": csrfToken() },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then(data => {

        this.amountsTarget.insertAdjacentHTML('afterbegin', data.inserted_item);
        this.formTarget.outerHTML = data.form;
      })

  }
}
