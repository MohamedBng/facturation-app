# encoding: utf-8

MoneyRails.configure do |config|
  # Définir la devise par défaut
  config.default_currency = :eur

  # Configurer le format d'affichage par défaut
  config.default_format = {
    no_cents_if_whole: false,
    format: "%n %u",
    decimal_mark: '.',
    thousands_separator: '.'
  }
end
