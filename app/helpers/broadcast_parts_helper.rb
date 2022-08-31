module BroadcastPartsHelper
    # def builder_nav(params, stock)
    #     "active" if params[:controller]=="stockholders" && stock.to_s==params[:stock_id].to_s
    # end


    def nav_link_active(step_name)
        link_to     step_name.humanize.titleize, 
                    wizard_path(step_name.to_sym), 
                    class: "nav-link active",
                    aria: "content: 'page'" 
                    
    end

    def nav_link(step_name)
        link_to     step_name.humanize.titleize, 
                    wizard_path(step_name.to_sym), 
                    class: "nav-link"
    end

    def nav_link_disabled(step_name)
        link_to     step_name.humanize.titleize,
                    wizard_path(step_name.to_sym),
                    class: "nav-link disabled",
                    aria: "disabled: 'true'" 
    end
end
