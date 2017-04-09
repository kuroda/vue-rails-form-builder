vue-form-for
============

A custom Rails form builder for Vue.js

Synopsis
--------

```
<%= vue_form_for User.new do |f| %>
  <%= f.text_field :name %>
<% end %>
```

```html
<form ...>
  ...
  <input v-model="user.name" type="text" name="user[name]" ... />
</form>
```

Installation
------------

Add the following line to `Gemfile`:

```ruby
gem "vue-form-for"
```

Run `bundle install` on the terminal.

Usage
-----

```
<%= vue_form_for User.new do |f| %>
  <%= f.text_field :name %>
  <%= f.submit "Create" %>
<% end %>
```

The above ERB template will be rendered into the following HTML fragment:

```html
<form class="new_user" id="new_user" action="/users" accept-charset="UTF-8" method="post">
  <input name="utf8" type="hidden" value="&#x2713;" />
  <input type="hidden" name="authenticity_token" value="..." />
  <input v-model="user.name" type="text" name="user[name]" id="user_name" />
  <input type="submit" name="commit" value="Create" />
</form>
```

Note that the third `<input>` element has a `v-model` attriubte, which can be
interpreted by Vue.js as the _directive_ to create two-way data bindings between
form fields and component's data.

If you are using the [Webpacker](https://github.com/rails/webpacker),
create `app/javascript/packs/new_user_form.js` with following code:

```javascript
import Vue from 'vue/dist/vue.esm'

document.addEventListener("DOMContentLoaded", () => {
  const NewUserForm = new Vue({
    el: "#new_user",
    data: {
      user: {
        name: ""
      }
    }
  })
})
```

Add this line to the ERB template:

```text
<%= javascript_pack_tag "new_user_form" %>
```

Then, you can get the value of `user[name]` field by the `user.name`.

Tag Helper
----------

This gem provides two additional helper methods: `vue_tag` and `vue_content_tag`.

Basically, they behave like `tag` and `content_tag` helpers of Action Views.
But, they interpret the *HTML options* in a different way as explained below.

### The `:bind` option

If the *HTML options* have a `:bind` key and its value is a hash,
they get transformed into the Vue.js `v-bind` directives.

In the example below, these two lines have the same result:

```
<%= vue_content_tag(:span, "Hello", bind: { style: "{ color: textColor }" })
<%= vue_content_tag(:span, "Hello", "v-bind:style" => "{ color: textColor }" })
```

Note that you should use the latter style if you want to specify *modifiers*
to the `v-bind` directives. For example:

```
<%= vue_content_tag(:span, "Hello", "v-bind:text-content.prop" => "message" })
```

### The `:on` option

If the *HTML options* have a `:on` key and its value is a hash,
they get transformed into the Vue.js `v-on` directives.

In the example below, these two lines have the same result:

```
<%= vue_content_tag(:span, "Hello", on: { click: "doThis" })
<%= vue_content_tag(:span, "Hello", "v-on:click" => "doThis" })
```

Note that you should use the latter style if you want to specify *modifiers*
to the `v-on` directives. For example:

```
<%= vue_content_tag(:span, "Hello", "v-on:click.once" => "doThis" })
<%= vue_content_tag(:button, "Hello", "v-on:click.prevent" => "doThis" })
```

### Boolean attributes

If the *HTML options* have a string value (not a boolean value)
for `checked`, `disabled`, `multiple`, `readonly` or `selected` key,
the key gets transformed by adding `v-bind:` to its head.

In the example below, these two lines have the same result:

```
<%= vue_content_tag(:button, "Click me!", disabled: "!clickable")
<%= vue_content_tag(:button, "Click me!", "v-bind:disabled" => "!clickable")
```

### Vue.js directives

If the *HTML options* have one or more of the following keys

> `text`, `html`, `show`, `if`, `else`, `else_if`, `for`, `model`, `pre`, `cloak`, `once`

then, these keys get transformed by adding `v-` to their head.

In the example below, these two lines have the same result:

```
<%= vue_tag(:hr`, `if: "itemsPresent")
<%= vue_tag(:hr, "v-if" => "itemsPresent")
```

Note that the `:else_if` key is transformed into the `v-else-if` directive:

```
<%= vue_tag(:hr, else_if: "itemsPresent")
<%= vue_tag(:hr, "v-else-if" => "itemsPresent")
```

### Extensions to the form building helpers

When you build HTML forms using `vue_form_for`,
the form building helpers, such as `text_field`, `check_box`, etc.,
have these additional behavior.

Example:

```
<%= vue_form_for User.new do |f| %>
  <%= f.text_field :name, model: "userName" %>
  <label>
    <%= f.check_box :administrator, on: { click: "doThis" } %> Administrator
  </label>
  <%= f.submit "Create", disabled: "!submittable" %>
<% end %>
```

License
-------

The `initial-test-data` is distributed under the MIT license. ([MIT-LICENSE](https://github.com/oiax/initial-test-data/blob/master/MIT-LICENSE))

Author
------

Tsutomu Kuroda (t-kuroda@oiax.jp)
