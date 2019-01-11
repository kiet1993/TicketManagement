Pod::Spec.new do |s|

  s.name          = "TicketManager"
  s.version       = "1.0.0"
  s.summary       = "Ticket manager sdk"
  s.description   = "Ticket management sdk demo"
  s.homepage      = "http://nal.vn"
  s.license       = "MIT"
  s.author        = "Phu Nguyen"
  s.platform      =       :ios, "9.0"
  s.source        = { :git => "https://github.com/kiet1993/TicketManagement.git", :tag => "1.0.2" }
  s.source_files  = 'TicketManagement', 'TicketManagement/Sources/**/*.swift'
  s.resources     = ['TicketManagement/Sources/**/*.{xib,storyboard,xcassets}']
  s.swift_version = "4.2"
  s.exclude_files = "Classes/Exclude"
end
