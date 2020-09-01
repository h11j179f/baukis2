class StaffMemberPresenter < ModelPresenter
  delegate :family_name, :given_name, :family_name_kana, :given_name_kana,:suspended?, to: :object

  def full_name
    family_name + " " + given_name
  end
  
  def full_name_kana
    family_name_kana + " " + given_name_kana
  end
  
  #職員の停止フラグのON/OFFを表現する記号を返す。
  #ON: BALLOT BOX WITH CHECK (U+2611)
  #OFF: BALLOT BOX (U+2610)
  def suspended_mark
    suspended? ? raw("&#x2611;") : raw("&#x2610;")
  end
end