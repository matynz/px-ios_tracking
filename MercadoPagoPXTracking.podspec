Pod::Spec.new do |s|
  s.name             = "MercadoPagoPXTracking"
  s.version          = "2.1.0"
  s.summary          = "MercadoPago PX Tracking"
  s.homepage         = "https://www.mercadopago.com"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = "Mercado Pago"
  s.source           = { :git => "https://github.com/mercadopago/px-ios_tracking", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true


  s.source_files = ['MercadoPagoPXTracking/*']

  s.swift_version = '4.0'

end
