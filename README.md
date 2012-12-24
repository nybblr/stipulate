Info
====
This gem was developed for use in a number of Rails projects. Very often "statusesque" string fields are used for maximum flexibility in designing state-sensitive models, such as a "pending" order or an "inactive" user. Homebrew solutions leave the individual statuses undocumented and require string sensitive comparisons. This gem introduces readability and adds some convenient method generation so that code remains readable, but just as flexible as the string field backing it.

Be sure to check out [nybblr.com](http://nybblr.com) for other Rails goodies, and if you're looking for more of my gems (when I get around to it!) go to nybblr.com/gems.

Why Stipulate?
--------------
If you don't specify what conditions apply, you might get sued.

Usage
=====
From your ActiveRecord model, simply call the stipulate method for each enumeratable type field:

``` ruby
class User < ActiveRecord::Base
	# Example usages
	stipulate :that => :status, :can_be => [:active, :inactive, :pending, :suspended]

	stipulate :that => :type, :can_be => [:admin, :moderator, :end_user]

	puts statuses # => "[:active, :inactive, :pending, :suspended]"

end
```

The stipulate method adds some convenience methods. As shown, a class method with the enumerated types is generated (for use in dropdowns, like this simple_form example):

``` erb
<%= simple_form_for :user do |f| %>
	<%= f.input :status,
		:as => :select,
		:collection => User.statuses.collect {|r| [r.to_s.titleize, r] } if can? :alter_role, f.object %>
<% end %>
```

For each enumeration, a boolean check method is generated:

``` ruby
User.last.admin?
```

To make sure CanCan works with cached DB objects, you can set the field as you normally would with a symbol or a string; both will be converted to a string, so in CanCan you can simply call:

``` ruby
can :edit, User, :status => "active"
```

...and not need to worry if a symbol was assigned to the in-memory object. Symbols are preferred for assigning because they emphasize the finiteness of inputs (there are only so many different statuses), they stand out from regular strings, and they enforce lowercase convention.
