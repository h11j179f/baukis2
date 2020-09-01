module PersonalNameHolder
  extend ActiveSupport::Concern

  KATAKANA_REGEX = /\A[\p{katakana}\u{30fc}]+\z/
  HUMAN_NAME_REGEX = /\A[\p{han}\p{hiragana}\p{katakana}u{30fc}A-Za-z]+\z/

  included do
    include StringNormalizer

    before_validation do
      self.family_name = normalize_as_name(family_name)
      self.given_name = normalize_as_name(given_name)
      self.family_name_kana = normalize_as_furigana(family_name_kana)
      self.given_name_kana = normalize_as_furigana(given_name_kana)
    end

    validates :family_name, :given_name, presence: true,
      format: { with: HUMAN_NAME_REGEX, allow_blank: true }
    validates :family_name_kana, :given_name_kana, presence: true,
      format: { with: KATAKANA_REGEX, allow_blank: true }
  end
end