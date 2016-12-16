class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!
  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.all.order(:cached_votes_score => :desc)
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @user = current_user
    @quote = @user.quotes.build(quote_params)

    respond_to do |format|
      if @quote.save
        format.html { redirect_to quotes_path, notice: 'Quote was successfully created.' }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1
  # PATCH/PUT /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @quote, notice: 'Quote was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end

  def update
    authorize! :manage, @quote

  end
  def destroy
    authorize! :manage, @quote

  end
end
  def destroy
  @quote = current_user.quotes.find(params[:id])
  @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_url, notice: 'Quote was successfully destroyed.' }
      format.json { head :no_content }
    end

  end



  def upvote
    @quote.upvote_from current_user
    redirect_to quotes_path
  end
  def downvote
    @quote.downvote_from current_user
    redirect_to quotes_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_params
      params.require(:quote).permit(:quote, :autor, :date)
    end
end
