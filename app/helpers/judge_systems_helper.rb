 require 'csv'   # csv操作を可能にするライブラリ
 require 'kconv'
 module JudgeSystemsHelper

  def import_csv(csv_file)
  # csvファイルを受け取って文字列にする
  csv_text = csv_file.read

  data = ""

  #文字列をUTF-8に変換
  CSV.parse(Kconv.toutf8(csv_text)) do |row|
   row.each do |obj|
     data += obj
     data += "\n"
   end
 end
 data  
end
module_function :import_csv
end
