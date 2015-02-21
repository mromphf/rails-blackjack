Card = Struct.new(:value, :suit) do
  def face?
    value > 10
  end
end
