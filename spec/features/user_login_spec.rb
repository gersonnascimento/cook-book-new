require 'rails_helper'

feature 'User login' do
  scenario 'create user' do 
    visit root_path
    click_on 'Entrar'
    click_on 'Fazer cadastro'
    fill_in 'Email', with: 'teste@teste.com.br'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação da senha', with: '123456'
    click_on 'Finalizar Cadastro'
   
    
    expect(page).to have_content('Cadastro efetuado com sucesso!')
    expect(page).not_to have_content('Finalizar Cadastro')
  end

  scenario 'login successfully' do
    visit root_path
    click_on 'Entrar'
    click_on 'Fazer cadastro'
    fill_in 'Email', with: 'teste@teste.com.br'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação da senha', with: '123456'
    click_on 'Finalizar Cadastro'
    click_on 'Sair'
    click_on 'Entrar'
    fill_in 'Email', with: 'teste@teste.com.br'
    fill_in 'Senha', with: '123456'
    click_on 'Acessar'

    expect(page).to have_content('Seja bem vindo')
    expect(page).not_to have_content('Acessar') 
  end
end
