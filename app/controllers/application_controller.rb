require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/posts/new' do
    erb :new
  end
  
  get '/posts' do
    @posts = Post.all
    erb :index
  end
  
  post '/posts' do
    Post.create name: params[:name], content: params[:content]
    
    redirect '/posts'
  end
  
  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end
  
  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    
    erb :edit
  end
  
  patch '/posts/:id' do
    @post = Post.find(params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    
    redirect "/posts/#{params[:id]}"
  end
  
  delete '/posts/:id' do
    Post.destroy params[:id]
  end
end