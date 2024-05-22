module SystemTestHelper
  def fill_in_rich_text_area(locator = nil, with:)
    trix_editor = find("trix-editor##{locator}", visible: false)

    find("##{locator}_trix_input", visible: false).set(with)

    execute_script("arguments[0].value = arguments[1]; arguments[0].dispatchEvent(new Event('input', { bubbles: true }));", trix_editor, with)
  end
end
