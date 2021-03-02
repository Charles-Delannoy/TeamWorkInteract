require 'rails_helper'

RSpec.describe RecommandationsController, type: :controller do
  fixtures :users, :axes

  let(:user) { users(:chrystelle) }
  let(:axe) { axes(:axe_1) }

  describe 'POST #create' do
    context 'invalid params' do
      before(:each) do
        sign_in user

        post :create, params: { axe_id: axe.id, recommandation: attributes_for(:recommandation_empty) }
      end

      it 'should render the new template' do
        expect(response).to render_template("new")
      end

      it 'should contain the validation error' do
        expect(assigns(:recommandation).errors.messages).to include(:description)
      end
    end

    context 'valid params' do
      before(:each) do
        sign_in user

        post :create, params: { axe_id: axe.id, recommandation: attributes_for(:recommandation) }
      end

      it 'should redirect to axe #show' do
        expect(response).to redirect_to(axe_url(axe.id))
      end

      it 'should persisted the recommandation' do
        expect(Recommandation.count).to eq(1)
      end

      it 'should link the recommandation to the axe' do
        expect(axe.recommandations.count).to eq(1)
      end

    end
  end
end
