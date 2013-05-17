module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def icon_true_false(checked=false)
    !!checked ? content_tag("i", "", class: "iconic-check", style: "color: #468847") : content_tag("i", "", class: "iconic-x", style: "color: #BD362F")
  end

  def link_to_destroy_fields(name, f, options={})
    f.hidden_field(:_destroy) + link_to_function(name, "destroy_fields(this)", options)
  end

  def link_to_create_fields(name, f, association, options={})
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.simple_fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render("#{association.to_s.singularize}_fields", :f => builder)
    end
    link_to_function(name, raw("create_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"), options)
  end

end
