class Customer::MessagesController < Customer::Base
  def new
    @message = CustomerMessage.new
  end

  def index
    @messages = current_customer.inbound_messages.sorted.page(params[:page])
  end

  def show
    @message = current_customer.inbound_messages.find(params[:id])
  end

  def confirm
    @message = CustomerMessage.new(customer_message_params)
    @message.customer = current_customer
    if @message.valid?
      render action: "confirm"
    else
      flash.now.alert = "入力に誤りがあります。"
      render action: "new"
    end
  end

  def create
    @message = CustomerMessage.new(customer_message_params)
    if params[:commit]
      @message.customer = current_customer
      if @message.save
        flash.notice = "問い合わせを送信しました。"
        redirect_to :customer_root
      else
        flash.now.alert = "入力に誤りがあります。"
        render action: "new"
      end
    else
      render action: "new"
    end
  end

  def destroy
    message = current_customer.inbound_messages.find(params[:id])
    message.update_column(:discarded, true)
    flash.notice = "メッセージを削除しました。"
    redirect_back(fallback_location: :cutomer_messages)
  end

  private def customer_message_params
    params.require(:customer_message).permit(:subject, :body)
  end
end
