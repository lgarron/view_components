# frozen_string_literal: true

module Primer
  # Use DetailsComponent to reveal content after clicking a button.
  class DetailsComponent < Primer::Component
    include ViewComponent::SlotableV2

    NO_OVERLAY = :none
    OVERLAY_MAPPINGS = {
      NO_OVERLAY => "",
      :default => "details-overlay",
      :dark => "details-overlay details-overlay-dark"
    }.freeze

    # Use the Summary slot as a trigger to reveal the content.
    #
    # @param kwargs [Hash] The same arguments as <%= link_to_system_arguments_docs %>.
    renders_one :summary, lambda { |button=true, **system_arguments|
      system_arguments = system_arguments
      system_arguments[:tag] = :summary
      system_arguments[:role] = "button"
      system_arguments[:tag] ||= :div

      Primer::BaseComponent.new(**@system_arguments) unless button

      Primer::ButtonComponent.new(**@system_arguments)
    }

    # Use the Body slot as the main content to be shown when triggered by the Summary.
    #
    # @param kwargs [Hash] The same arguments as <%= link_to_system_arguments_docs %>.
    renders_one :body, lambda { |**system_arguments|
      system_arguments[:tag] ||= :div
      Primer::BaseComponent.new(**system_arguments)
    }

    # @example 100|Default
    #   <%= render(Primer::DetailsComponent.new(overlay: :default, reset: true, position: :relative)) do |c| %>
    #     <% c.summary do %>
    #       Click me
    #     <% end %>
    #
    #     <% c.body do %>
    #       Body
    #     <% end %>
    #   <% end %>
    #
    # @example 100|Custom button
    #   <%= render(Primer::DetailsComponent.new(overlay: :default, reset: true, position: :relative)) do |c| %>
    #     <% c.summary(variant: :small, button_type: :primary) do %>
    #       Click me
    #     <% end %>
    #
    #     <% c.body do %>
    #       Body
    #     <% end %>
    #   <% end %>
    #
    # @example 100|Without button
    #   <%= render(Primer::DetailsComponent.new(overlay: :default, reset: true, position: :relative)) do |c| %>
    #     <% c.summary(button: false) do %>
    #       Click me
    #     <% end %>
    #
    #     <% c.body do %>
    #       Body
    #     <% end %>
    #   <% end %>
    #
    # @param overlay [Symbol] Dictates the type of overlay to render with. <%= one_of(Primer::DetailsComponent::OVERLAY_MAPPINGS.keys) %>
    # @param reset [Boolean] Defatuls to false. If set to true, it will remove the default caret and remove style from the summary element
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(overlay: NO_OVERLAY, reset: false, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = :details
      @system_arguments[:classes] = class_names(
        system_arguments[:classes],
        OVERLAY_MAPPINGS[fetch_or_fallback(OVERLAY_MAPPINGS.keys, overlay, NO_OVERLAY)],
        "details-reset" => reset
      )
    end

    def render?
      summary.present? && body.present?
    end
  end
end
