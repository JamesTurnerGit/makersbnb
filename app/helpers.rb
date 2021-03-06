module Helpers

  def current_user
    @current_user ||= User.get(session[:user_id])
  end

  def error?
    flash[:errors] && !flash[:errors].empty?
  end

  def body_class(class_name="default")
    @body_class = class_name
  end

  def booking_status(status)
    return "pending" if status.nil?
    return "accepted" if status
    return "declined" unless status
  end

  def pretty_start_date(booking)
    "From #{format_date(booking.date_range.start_date)} "
  end

  def pretty_end_date(booking)
    "to #{format_date(booking.date_range.end_date)}"
  end

  def format_date(date)
    date.strftime("%d/%m/%Y")
  end

  def sign_out_helper
    session[:user_id] = nil
    flash.keep[:notice] = 'Goodbye!'

  end

  def pretty_money(money)
    pennies = ("00" + money.to_s)[-2..-1]
    pounds =  (money.to_s[0..-3])
    pounds = "0" if pounds == ""
    "#{pounds}.#{pennies}"
  end

  def pounds_to_pence(money)
    money.to_i * 100
  end

  def booking_confirm(booking_id, confirmed)
    booking = Booking.first(id: booking_id)
    if confirmed == "true"
      booking.update(confirmed: true)
    else
      booking.update(confirmed: false)
    end
  end
end
