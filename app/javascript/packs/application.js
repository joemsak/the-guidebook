// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "stylesheets/application"

(() => {
  document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('[data-opens]').forEach(btn => {
      btn.addEventListener('click', () => {
        const menuId = btn.dataset.opens
        const menu = document.getElementById(menuId)

        btn.setAttribute('aria-expanded', true)
        menu.querySelector('[data-closes]').setAttribute('aria-expanded', true)

        menu.classList.remove('hidden')
        menu.classList.add('block')
      })
    })

    document.querySelectorAll('[data-closes]').forEach(btn => {
      btn.addEventListener('click', () => {
        const menuId = btn.dataset.closes
        const menu = document.getElementById(menuId)

        btn.setAttribute('aria-expanded', false)
        document.getElementById(`${menuId}-btn`).setAttribute('aria-expanded', false)

        menu.classList.add('hidden')
        menu.classList.remove('block')
      })
    })
  })
})()
