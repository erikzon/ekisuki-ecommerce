import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["items"]

    toggle() {
        setTimeout(this.itemsTarget.classList.toggle('-translate-x-full'),300)
    }
}
