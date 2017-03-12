require 'timeout'

class SandBox
  def self.run(submit_code, input_file, ans_file, time)
    return StandardError unless block_given?
    result_or_error = nil
    begin
      Timeout::timeout time do
        result_or_error = Thread.new do
          $SAFE = 1
          system "ruby #{submit_code} < #{input_file} > #{ans_file}"
        end.value
      end
    rescue StandardError, SecurityError, Timeout::Error => e
      result_or_error = e
    end
    yield result_or_error
  end
end