require_dependency "erp/application_controller"

module Erp
  module Contacts
    module Backend
      class ContactsController < Erp::Backend::BackendController
        before_action :set_contact, only: [:edit, :update, :destroy]
    
        # GET /contacts
        def index
        end
        
        # POST /contacts/list
        def list
          @contacts = Contact.all.paginate(:page => params[:page], :per_page => 3)
          
          render layout: nil
        end
    
        # GET /contacts/new
        def new
          @contact = Contact.new
        end
    
        # GET /contacts/1/edit
        def edit
        end
    
        # POST /contacts
        def create
          @contact = Contact.new(contact_params)
    
          if @contact.save
            redirect_to erp_contacts.edit_backend_contact_path(@contact), notice: 'Contact was successfully created.'
          else
            render :new
          end
        end
    
        # PATCH/PUT /contacts/1
        def update
          if @contact.update(contact_params)
            redirect_to erp_contacts.edit_backend_contact_path(@contact), notice: 'Contact was successfully updated.'
          else
            render :edit
          end
        end
    
        # DELETE /contacts/1
        def destroy
          @contact.destroy
          
          respond_to do |format|
            format.html { redirect_to erp_contacts.backend_contacts_path, notice: 'Contact was successfully destroyed.' }
            format.json {
              render json: {
                'message': 'Contact was successfully destroyed.',
                'type': 'success'
              }
            }
          end          
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_contact
            @contact = Contact.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def contact_params
            params.fetch(:contact, {})
          end
      end
    end
  end
end
