vue-rails-form-builder
======================

[![Gem Version](https://badge.fury.io/rb/vue-rails-form-builder.svg)](https://badge.fury.io/rb/vue-rails-form-builder)

A custom Rails form builder for Vue.js

Synopsis
--------

```erb
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
gem "vue-rails-form-builder"
```

Run `bundle install` on the terminal.

Usage
-----

```erb
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

```erb
<%= javascript_pack_tag "new_user_form" %>
```

Then, you can get the value of `user[name]` field by the `user.name`.

If you use Rails 5.1 or above, you can also use `vue_form_with`:

```erb
<%= vue_form_with model: User.new do |f| %>
  <%= f.text_field :name %>
  <%= f.submit "Create" %>
<% end %>
```

By default, this gem render v-model tag with object and attributes snake-cased just like your model table columns. If you want to render the v-model tag with object and attribute camelized, you can pass the option `camelize` to the vue_form_for or vue_form_with tag:

```erb
<%= vue_form_with(model: GenericModel.new, camelize: true) do |f| %>
  <%= f.text_field :generic_field %>
  <%= f.submit "Create" %>
<% end %>
```

This will render:

```html
 <input type="text" name="generic_model[generic_field]" id="generic_model_generic_field" v-model="genericModel.genericField"> 
```

Demo App
--------

Visit [vue-rails-form-builder-demo](https://github.com/kuroda/vue-rails-form-builder-demo)
for a working Rails demo application using the `vue-rails-form-builder`.

Options
-------

To `vue_form_for` and `vue_form_with` methods you can provide the same options
as `form_for` and `form_with`.

There is a special option:

* `:vue_scope` - The prefix used to the input field names within the Vue
  component.

Tag Helper
----------

This gem provides two additional helper methods: `vue_tag` and `vue_content_tag`.

Basically, they behave like `tag` and `content_tag` helpers of Action Views.
But, they interpret the *HTML options* in a different way as explained below.

### The `:bind` option

If the *HTML options* have a `:bind` key and its value is a hash,
they get transformed into the Vue.js `v-bind` directives.

In the example below, these two lines have the same result:

```erb
<%= vue_content_tag(:span, "Hello", bind: { style: "{ color: textColor }" }) %>
<%= vue_content_tag(:span, "Hello", "v-bind:style" => "{ color: textColor }" }) %>
```

Note that you should use the latter style if you want to specify *modifiers*
to the `v-bind` directives. For example:

```erb
<%= vue_content_tag(:span, "Hello", "v-bind:text-content.prop" => "message" }) %>
```

### The `:on` option

If the *HTML options* have a `:on` key and its value is a hash,
they get transformed into the Vue.js `v-on` directives.

In the example below, these two lines have the same result:

```erb
<%= vue_content_tag(:span, "Hello", on: { click: "doThis" }) %>
<%= vue_content_tag(:span, "Hello", "v-on:click" => "doThis" }) %>
```

Note that you should use the latter style if you want to specify *modifiers*
to the `v-on` directives. For example:

```erb
<%= vue_content_tag(:span, "Hello", "v-on:click.once" => "doThis" }) %>
<%= vue_content_tag(:button, "Hello", "v-on:click.prevent" => "doThis" }) %>
```

### Boolean attributes

If the *HTML options* have a string value (not a boolean value)
for `checked`, `disabled`, `multiple`, `readonly` or `selected` key,
the key gets transformed by adding `v-bind:` to its head.

In the example below, these two lines have the same result:

```erb
<%= vue_content_tag(:button, "Click me!", disabled: "!clickable") %>
<%= vue_content_tag(:button, "Click me!", "v-bind:disabled" => "!clickable") %>
```

If you want to add a normal attribute without `v-bind:` prefix,
specify `true` (boolean) to these keys:

```erb
<%= vue_content_tag(:button, "Click me!", disabled: true) %>
```

This line produces the following HTML fragment:

```html
<button disabled="disabled">Click me!</button>
```


### Vue.js directives

If the *HTML options* have one or more of the following keys

> `text`, `html`, `show`, `if`, `else`, `else_if`, `for`, `model`, `pre`, `cloak`, `once`

then, these keys get transformed by adding `v-` to their head.

In the example below, these two lines have the same result:

```erb
<%= vue_tag(:hr, if: "itemsPresent") %>
<%= vue_tag(:hr, "v-if" => "itemsPresent") %>
```

Note that the `:else_if` key is transformed into the `v-else-if` directive:

```erb
<%= vue_tag(:hr, else_if: "itemsPresent") %>
<%= vue_tag(:hr, "v-else-if" => "itemsPresent") %>
```

### Extensions to the form building helpers

When you build HTML forms using `vue_form_for`,
the form building helpers, such as `text_field`, `check_box`, etc.,
have these additional behavior.

Example:

```erb
<%= vue_form_for User.new do |f| %>
  <%= f.text_field :name, model: "userName" %>
  <label>
    <%= f.check_box :administrator, on: { click: "doThis" } %> Administrator
  </label>
  <%= f.submit "Create", disabled: "!submittable" %>
<% end %>
```

The `vue_prefix` method of the Form Builder
-------------------------------------------

When you build HTML forms using `vue_form_for`, the form builder has the
`vue_prefix` method that returns the *prefix string* to the Vue.js property names.

See the following code:

```erb
<%= vue_form_for User.new do |f| %>
  <%= f.text_field :name %>
  <%= f.submit "Create", disabled: "user.name === ''" %>
<% end %>
```

The `vue_prefix` method of the form builder (`f`) returns the string `"user"`
so that you can rewrite the third line of the example above like this:

```erb
  <%= f.submit "Create", disabled: "#{f.vue_prefix}.name === ''" %>
```

This method is convenient especially when the form has nested attributes:

```erb
<%= vue_form_for @user do |f| %>
  <%= f.text_field :name %>
  <%= f.fields_for :emails do |g| %>
    <%= g.text_field :address,
      disabled: "user.emails_attributes[#{g.index}]._destroy" %>
    <%= g.check_box :_destroy if g.object.persisted? %>
  <% end %>
  <%= f.submit "Create", disabled: "#{f.vue_prefix}.name === ''" %>
<% end %>
```

Using the `vue_prefix` method, you can rewrite the fifth line more concisely:

```erb
      disabled: g.vue_prefix + "._destroy" %>
```

Data Initialization
-------------------

As the official Vue.js document says:

> `v-model` will ignore the initial `value`, `checked` or `selected` attributes
> found on any form elements.
> (https://vuejs.org/v2/guide/forms.html)

Because of this, all form controls get reset after the Vue component is mounted.

However, you can use
[vue-data-scooper](https://github.com/kuroda/vue-data-scooper) plugin
in order to keep the original state of the form.

License
-------

The `vue-rails-form-builder` is distributed under the MIT license. ([MIT-LICENSE](https://github.com/kuroda/vue-rails-form-builder/blob/master/MIT-LICENSE))

Author
------

Tsutomu Kuroda (t-kuroda@oiax.jp)
