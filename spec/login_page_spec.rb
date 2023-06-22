# frozen_string_literal: true

require_relative '../helpers/spec_helper'
require_relative '../models/model_factory'
require_relative '../page_objects/pages/account_page'
require_relative '../page_objects/pages/login_page'

describe 'Login' do
  subject(:header) { account_page.header.customer_name }

  let(:user) { ModelFactory.for('users')['registered user'] }
  let(:login_page) { LoginPage.new(browser) }
  let(:account_page) { AccountPage.new(browser) }

  before do
    login_page.visit
    login_page.login(user['username'], password)
  end

  context 'with right credentials' do
    let(:password) { user['password'] }

    it 'can successfully log in' do
      expect(header).to eq "Welcome back #{user['name']}"
    end
  end

  context 'with wrong credentials' do
    let(:password) { 'wrongPassword' }

    it 'cannot log in' do
      expect(header).to be_empty
    end
  end
end
