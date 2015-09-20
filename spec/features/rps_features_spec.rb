require 'spec_helper'

feature 'Starting the game:' do

  scenario 'displays welcome message' do
    visit '/'
    expect(page).to have_content 'Welcome, brave marketeer.'
  end

  scenario 'lets player enter name and remembers it' do
    visit '/'
    fill_in 'player', with: 'Steerpike'
    click_button 'GO'
    expect(page).to have_content 'Choose your weapon, Steerpike.'
  end

end

feature 'Playing a round:' do

  before do
    srand(0) # seeds RNG to ensure computer chooses Rock
    visit '/'
    fill_in 'player', with: 'Steerpike'
    click_button 'GO'
  end

  scenario 'displays the scores' do
    expect(page).to have_content 'Scores: Steerpike 0, Computer 0'
  end

  scenario 'offers a choice of weapons' do
    expect(page).to have_selector 'input[type=radio][value="Scissors"]'
  end

  scenario 'lets player choose a weapon' do
    choose 'Scissors'
    click_button 'THROW SHAPE'
    expect(page).to have_content 'Steerpike threw Scissors.'
  end

  scenario 'makes the computer choose a weapon' do
    click_button 'THROW SHAPE'
    expect(page).to have_content 'The computer threw Rock'
  end

end

feature 'Displaying round results:' do

  before do
    srand(0) # seeds RNG to ensure computer chooses Rock
    visit '/'
    fill_in 'player', with: 'Steerpike'
    click_button 'GO'
  end

  scenario 'summarises the contest' do
    choose 'Scissors'
    click_button 'THROW SHAPE'
    expect(page).to have_content 'Rock blunts Scissors.'
  end

  scenario 'announces if player has won' do
    choose 'Paper'
    click_button 'THROW SHAPE'
    expect(page).to have_content 'Steerpike wins!'
  end

  scenario 'increases player score if player has won' do
    choose 'Paper'
    click_button 'THROW SHAPE'
    expect(page).to have_content 'Scores: Steerpike 1, Computer 0'
  end

  scenario 'announces if player has lost' do
    choose 'Scissors'
    click_button 'THROW SHAPE'
    expect(page).to have_content 'Computer wins!'
  end

  scenario 'increases computer score if player has lost' do
    choose 'Scissors'
    click_button 'THROW SHAPE'
    expect(page).to have_content 'Scores: Steerpike 0, Computer 1'
  end

  scenario 'deals with ties' do
    choose 'Rock'
    click_button 'THROW SHAPE'
    expect(page).to have_content 'It\'s a tie... meh.'
  end

  scenario 'leaves score unchanged if round tied' do
    choose 'Rock'
    click_button 'THROW SHAPE'
    expect(page).to have_content 'Scores: Steerpike 0, Computer 0'
  end

end

feature 'Ending the round or game:' do

  before do
    srand(0) # seeds RNG to ensure computer chooses Rock
    visit '/'
    fill_in 'player', with: 'Steerpike'
    click_button 'GO'
    choose 'Scissors'
    click_button 'THROW SHAPE'
  end

  scenario 'plays another round on request' do
    click_button 'Play another round'
    expect(page).to have_content 'Choose your weapon, Steerpike.'
  end

  scenario 'resets the scores on request' do
    click_button 'Reset the scores'
    expect(page).to have_content 'Scores: Steerpike 0, Computer 0'
  end

  scenario 'restarts the game on request' do
    click_button 'Log out and restart'
    expect(page).to have_content 'Welcome, brave marketeer.'
  end

end
