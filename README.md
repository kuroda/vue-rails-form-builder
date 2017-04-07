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

Other Functionalities
---------------------

You can provide a hash to the `:v` option:

```
<%= vue_form_for User.new do |f| %>
  <%= f.text_field :name, v: { model: "customer.name" } %>
  <%= f.submit "Create", v: { if: "submittable" } %>
<% end %>
```

The above ERB template is identical with the following one:

```
<%= vue_form_for User.new do |f| %>
  <%= f.text_field :name, "v-model" => "customer.name" %>
  <%= f.submit "Create", "v-if" => "submittable" %>
<% end %>
```

License
-------

The `initial-test-data` is distributed under the MIT license. ([MIT-LICENSE](https://github.com/oiax/initial-test-data/blob/master/MIT-LICENSE))

Author
------

Tsutomu Kuroda (t-kuroda@oiax.jp)
