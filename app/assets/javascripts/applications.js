//= require jquery
//= require bootstrap-sprockets
//= require clipboard
//= require turbolinks


document.addEventListener('DOMContentLoaded', function() {
  new ClipboardJS('.clipboard-btn');
});
  

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("./controllers", true, /\.js$/)
application.load(definitionsFromContext(context))