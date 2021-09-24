FactoryBot.define do
  factory :user do
    approved { true }
    email { 'test@email.com' }
    password { 'test12345' }
    username { 'test_123' }
    full_name { 'Testing ony' }
  end

  factory :user_pending, class: 'User' do
    approved { false }
    email { 'test_pending@email.com' }
    password { 'test12345' }
    username { 'test_123' }
    full_name { 'Testing ony' }
  end

  factory :user_buyer, class: 'User' do
    approved { false }
    email { 'test_buy@email.com' }
    password { 'test12345' }
    username { 'test_123' }
    full_name { 'Testing ony' }
  end

  factory :admin do
    email { 'akotosiAdmin@emporia.com' }
    password { 'adminniyo123' }
    username { 'Ako_si_admin' }
    full_name { 'Your Admin' }
  end

  factory :market do
    market_symbol { 'AA' }
    curr_price { 99.99 }
    logo_url { 'url_logo_here' }
  end

  factory :buy_market, class: 'Portfolio' do
    user_id { 2 }
    market_symbol { 'AA' }
    hist_price { 25.95 }
    amount { 1.5 }
    market_id { 2 }
    transaction_type { 'Buy' }
    units { 0.5 }
  end

  factory :sell_market, class: 'Portfolio' do
    user_id { 2 }
    market_symbol { 'AA' }
    hist_price { 26.5 }
    amount { 1.2 }
    market_id { 2 }
    transaction_type { 'Sell' }
    units { 0.5 }
  end
end
