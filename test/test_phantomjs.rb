require 'phantomjs'

class PhantomjsTest < Test::Unit::TestCase
  def test_phantomjs_run
    file = Tempfile.new('phantomjstest')
    file.write("console.log('test');phantom.exit();")
    file.close
    assert_equal 'test', Phantomjs.run(file.path).strip
    file.unlink
  end

  def test_timeout
    file = Tempfile.new('phantomjstest')
    file.write("console.log('this will not exit');")
    file.close
    assert_equal "Couldn't render page... orz", Phantomjs.run(file.path)
    file.unlink
  end
end
