require 'prawn'

module GeneratePdf
  PDF_OPTIONS = {
    # Escolhe o Page size como uma folha A4
    :page_size   => "A4",
    # Define o formato do layout como portrait (poderia ser landscape)
    :page_layout => :portrait,
    # Define a margem do documento
    :margin      => [40, 75]
  }
 
def self.generate_trips_reports user, trips, month
    
    #file_url = "public/reports/#{user.id}/#{Time.now.to_time.to_i}/#{month.downcase}_trips.pdf"
    external_url = "#{Time.now.to_time.to_i}_#{user.id}_trips.pdf"
    file_url = "public/#{external_url}"
    
    Prawn::Document.new(PDF_OPTIONS) do |pdf|
      
      pdf.fill_color "666666"
  
      pdf.text "Toptal Trips", :size => 32, :style => :bold, :align => :center
      
      pdf.move_down 80
      
      pdf.text "Those are the trips of  #{user.name} in the next 30 days ", :size => 12, :align => :justify, :inline_format => true
      
      pdf.move_down 30
      
      table_trips = []
      
      trips.each do |trip|
        pdf.text "#{trip.destination} at #{trip.start_date.to_date}", :size => 12, :align => :justify, :inline_format => true
        pdf.move_down 10
      end

      pdf.number_pages "Generated at: #{(Time.now).strftime("%d/%m/%y as %H:%M")} - Page ", :start_count_at => 0, :page_filter => :all, :at => [pdf.bounds.right - 140, 7], :align => :right, :size => 8

      pdf.render_file(file_url)
      
    end

    external_url
end
 
end