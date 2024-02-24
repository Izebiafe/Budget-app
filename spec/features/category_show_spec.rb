require 'rails_helper'

RSpec.feature 'Category Show Page', type: :feature do
  let!(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category) }
  let(:purchase) { FactoryBot.build(:purchase) }

  before do
    purchase.categories << category
    purchase.save
    login_as(user, scope: :user)
  end

  before(:each) { visit category_path(category) }

  scenario 'displays category details and purchases' do
    expect(page).to have_content('Category')
    expect(page).to have_content('Total:')
    expect(page).to have_content('Purchase')
  end

  scenario 'navigates back to categories index' do
    click_on 'Back'
    expect(page).to have_current_path(categories_path)
  end
end
