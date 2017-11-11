# CHANGELOG - vue-rails-form-builder

## 0.7.0 (2017-11-11)

* Support nested attributes.

## 0.6.0 (2017-05-14)

* Add `vue_scope` option to `vue_form_for` and `vue_form_with` methods.

## 0.5.0 (2017-05-12)

* Change the name of this gem to `vue-rails-form-builder` from `vue-form-for`.

## 0.4.0 (2017-05-11)

* Support SELECT tag.

## 0.3.3 (2017-05-09)

* Generate v-model attr for check boxes and radio buttons.

## 0.3.2 (2017-05-09)

* Generate correct value for v-model on nested form.

## 0.3.1 (2017-04-11)

* Fix `check_box` and `radio_button` helper methods.

## 0.3.0 (2017-04-09)

* Add `vue_tag` and `vue_content_tag` helper methods
  that can handle `:bind`, `:on`, `:checked`, `:disabled`, `:multiple`,
  `:readonly`, `:selected`, `:text`, `:html`, `:show`, `:if`, `:else`,
  `:else_if`, `:for`, `:model`, `:pre`, `:cloak`, `:once` options.
* Add similar functionalities to the form building helpers.
* Remove `:v` option handling.

## 0.2.0 (2017-04-07)

* Allow the form builder to resolve `:v` option.

## 0.1.0 (2017-04-05)

* The first release with minimum functionalities.
