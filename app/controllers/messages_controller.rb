# encoding: utf-8
class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  before_filter :confirm_logged, :only => [:new, :edit, :create, :update, :destroy]
  def index
    if params[:category_id]
    @messages = Message.where(:category_id => params[:category_id])
    else
      @messages = Message.order('created_at desc').all
    end

    @categories = Category.all

    @last_message = Message.find(:all, :limit => 5, :order=> 'created_at desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  
  def show
    @message = Message.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(params[:message])

    @message.user_id = current_user.id

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end
  def add_comment
    @message = Message.find(params[:id])
    content = params[:content]
    @comment = Comment.create(:user_id => current_user.id, :content => content, :message_id => @message.id)

    if @message.errors.blank?
      redirect_to @message
    else
      render :show
    end
  end

  def like
    @current_message = Message.find(params[:id])
    #@comment = Comment.where(:message_id => params[:message_id])
    @mes = @current_message.comment.find(params[:message_id])

    if @mes.like
    new_like = @mes.like + 1
    @mes.update_attributes(:like => new_like)
    @mes.save
    else
    new_like = @mes.like = 0
    @mes.update_attributes(:like => new_like)
    @mes.save
    end

    redirect_to @current_message
  end

  def dislike
    @current_message = Message.find(params[:id])
    #@comment = Comment.where(:message_id => params[:message_id])
    @mes = @current_message.comment.find(params[:message_id])

    if @mes.dislike
    new_dislike = @mes.dislike + 1
    @mes.update_attributes(:dislike => new_dislike)
    @mes.save
    else
    new_dislike = @mes.dislike = 0
    @mes.update_attributes(:dislike => new_dislike)
    @mes.save
    end

    redirect_to @current_message
  end

end
