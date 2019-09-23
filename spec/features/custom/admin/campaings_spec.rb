require "rails_helper"

describe "Admin campaings" do

  before do
    login_as(create(:administrator).user)
  end

  it_behaves_like "edit_translatable",
                  "campaing",
                  "edit_admin_campaing_path",
                  %w[title],
                  { "description" => :ckeditor }

  describe "Index" do
    let!(:campaing) { create(:campaing) }

    scenario "Should show existing campaings" do
      visit admin_campaings_path

      expect(page).to have_content campaing.title
      expect(page).to have_content I18n.l campaing.starts_at
      expect(page).to have_content I18n.l campaing.ends_at
    end
  end

  describe "create" do

    scenario "Should show validation errors" do
      visit new_admin_campaing_path

      click_on "Save"

      expect(page).to have_content "4 Errors"
    end

    scenario "Should Show success notice" do
      visit new_admin_campaing_path

      last_week = Time.current - 1.week
      next_week = Time.current + 1.week
      fill_in "Title", with: "Amazing campaing title"
      fill_in "Description", with: "Awesome description"
      fill_in "Starts at", with: last_week.strftime("%d/%m/%Y")
      fill_in "Ends at", with: next_week.strftime("%d/%m/%Y")
      click_on "Save"

      expect(page).to have_content "New campaing was created succesfully!"
    end
  end

  describe "update" do
    let!(:campaing) { create(:campaing) }

    scenario "Should show success notice" do
      visit edit_admin_campaing_path(campaing)

      fill_in "Title", with: "Updated title"
      click_on "Save"

      expect(page).to have_content "Campaing updated successfully!"
    end

    scenario "Should update attributes" do
      visit edit_admin_campaing_path(campaing)

      fill_in "Title", with: "Updated title"
      fill_in "Description", with: "Updated description"
      click_on "Save"
      visit edit_admin_campaing_path(campaing)

      expect(page).to have_field "Title", with: "Updated title"
      expect(page).to have_field "Description", with: "Updated description"
    end
  end

  describe "destroy" do
    let!(:campaing) { create(:campaing) }

    scenario "Should show success notice after destroy a campaing" do
      visit admin_campaings_path

      click_on "Delete"

      expect(page).to have_content "Campaing deleted successfully!"
    end
  end
end
