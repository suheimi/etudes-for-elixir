defmodule Dates do
  @moduledoc """ 
  Functions for manipulating calendar dates.
  
  from *Études for Elixir*, O'Reilly Media, Inc., 2013.
  Copyright 2013 by J. David Eisenberg.
  """ 
  @vsn 0.1 

  @doc "Calculate julian date from an ISO date string"
  
  @spec julian(String.t) :: number
  
  def julian(date_str) do
    [y, m, d] = date_parts(date_str)
    days_per_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    result = month_total(m, days_per_month) + d
    cond  do
      is_leap_year(y) and m > 2 -> result + 1
      true -> result
    end
  end
  
  @spec month_total(number, [number]) :: number
  
  # Helper function that recursively accumulates days
  # for all months up to (but not including) the current month

  defp month_total(m, days_per_month) do
    {relevant, _} = Enum.split(days_per_month, m - 1)
    List.foldl(relevant, 0, fn(x, acc) -> x + acc end)
  end
    
  defp is_leap_year(year) do
    (rem(year,4) == 0 and rem(year,100) != 0)
    or (rem(year, 400) == 0)
  end

  @doc """
  Takes a string in ISO date format (yyyy-mm-dd) and
  returns a list of integers in form [year, month, day].
  """
  @spec date_parts(list) :: list

  def date_parts(date_str) do
    [y_str, m_str, d_str] = String.split(date_str, ~r/-/)
    [binary_to_integer(y_str), binary_to_integer(m_str),
      binary_to_integer(d_str)]
  end
end
