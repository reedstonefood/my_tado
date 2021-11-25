# frozen_string_literal: true

RSpec.describe MyTado::OAuthClient do
  subject {
    MyTado::OAuthClient.new(
      client_secret: test_client_secret,
      username: test_username,
      password: test_password,
    )
  }

  # There are no known test credentials to use here, so the only way to test it is
  # to put your actual refresh token in as test_refresh_token.
  # Therefore this test is skipped by default, but developers can check
  # this code by putting a real refresh token in above.
  skip "gives expected results when using username & password" do
    response = subject.using_username_and_password
    expect(response.code).to eq(200)
    expect(response["token_type"]).to eq("bearer")

    access_token_from_username_and_password = subject.access_token(preferred_method: "password")
    expect(access_token_from_username_and_password).not_to be_nil

    expect(subject.using_refresh_token.code).to eq(200)
    expect(subject.using_refresh_token["token_type"]).to eq("bearer")

    # This should now have changed to a new access token with a new expiry time
    access_token_from_refresh_token = subject.access_token
    expect(access_token_from_refresh_token).not_to be_nil
    expect(access_token_from_refresh_token).not_to eq(access_token_from_username_and_password)
  end
end
