import { Application } from "@hotwired/stimulus"

const application = Application.start()
// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

import { Alert } from "tailwindcss-stimulus-components"
application.register('alert', Alert)

export { application }