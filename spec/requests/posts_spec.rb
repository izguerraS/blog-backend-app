require 'rails_helper'

RSpec.describe "Posts", type: :request do

  # INDEX ACTION****************************************
  describe "GET /posts/" do
    it "should return all the posts" do

      user = User.create!(
        name: "Sam",
        email: "Sam@sam.com",
        password_digest: "password"
      )
      

      post = Post.create!(
      user_id: user.id,
      title: "Test Post",
      body: "This is a test",
      image: "",
    )
      post = Post.create!(
      user_id: user.id,
      title: "Test Post",
      body: "This is a test",
      image: "",
    )        
      post = Post.create!(
      user_id: user.id,
      title: "Test Post",
      body: "This is a test",
      image: "",
    )
      post = Post.create!(
      user_id: user.id,
      title: "Test Post",
      body: "This is a test",
      image: "",
    )
      post = Post.create!(
      user_id: user.id,
      title: "Test Post",
      body: "This is a test",
      image: "",
    )
      post = Post.create!(
      user_id: user.id,
      title: "Test Post",
      body: "This is a test",
      image: "",
    )
      post = Post.create!(
      user_id: user.id,
      title: "Test Post",
      body: "This is a test",
      image: "",
    )
      post = Post.create!(
      user_id: user.id,
      title: "Test Post",
      body: "This is a test",
      image: "",
    ) 
      post = Post.create!(
      user_id: user.id,
      title: "Test Post",
      body: "This is a test",
      image: "",
    )                      

      get "/api/posts"
      posts = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(posts.length).to eq(9)
    end
  end

   # SHOW ACTION****************************************
  describe "get /posts/:id" do
    it 'should return one specific post' do
      user = User.create!(email: "Eric@eric.com", password: "password", name: "Eric")

      post = Post.create!(
        user_id: user.id,
        title: "Show working",
        body: "Show body working",
        image: "",
      )
      get "/api/posts/#{post.id}"

      post = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(post['title']).to eq ('Show working')
      expect(post['body']).to eq('Show body working')
    end
  end

   # CREATE ACTION****************************************
  describe "POST /posts" do
    it 'should create a new post' do
      user = User.create!(email: "Mike@mike.com", password: "password", name: "Mike")

      #generate token required#***************
      jwt = JWT.encode(
        {
          user: user.id, # the data to encode
          exp: 24.hours.from_now.to_i # the expiration time
        },
        "random", # the secret key
        'HS256' # the encryption algorithm
      )      
      post "/api/posts", params: {
        user_id: user.id,
        title: "Create working",
        body: "Create body working",
        image: ""
      }, headers: {
        "Authorization" => "Bearer #{jwt}"
      }
      post = JSON.parse(response.body)
      
      expect(response).to have_http_status(200)
      expect(post['body']).to eq('Create body working')
    end
    it "should return errors when user does not pass validations" do
    user = User.create!(email: "Laura@laura.com", password: "password", name: "Laura")

     #generate token required#***************
     jwt = JWT.encode(
       {
         user_id: user.id, # the data to encode
         exp: 24.hours.from_now.to_i # the expiration time
       },
      "random", # the secret key
      'HS256' # the encryption algorithm
    )
    post "/api/posts", headers: {
      "Authorization" => "Bearer #{jwt}"
    }
    errors = JSON.parse(response.body)      
    p errors
    expect(response).to have_http_status(:unprocessable_entity)
    expect(errors['errors']).to eq(["Title can't be blank", "body can't be blank"])
    end     
  end
end
