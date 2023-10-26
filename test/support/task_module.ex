defmodule TestSupport.Task do
  def async(func) do
    func.()
    %Task{pid: nil, ref: nil, owner: self(), mfa: {:erlang, :apply, 0}}
  end
end
