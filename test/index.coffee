test = require 'tape'
Hexo = require 'hexo'
minifier = require '../lib/filter'


html = """
<nav>
	<ul>
		<li><a href="#">Home</a></li>
		<li><a href="#">About</a></li>
		<li><a href="#">Clients</a></li>
		<li><a href="#">Contact Us</a></li>
	</ul>
</nav>
<form action="#" method="post">
    <div>
         <label for="name">Text Input:</label>
         <input type="text" name="name" id="name" value="" tabindex="1" />
    </div>

    <div>
         <h4>Radio Button Choice</h4>

         <label for="radio-choice-1">Choice 1</label>
         <input type="radio" name="radio-choice-1" id="radio-choice-1" tabindex="2" value="choice-1" />

		 <label for="radio-choice-2">Choice 2</label>
         <input type="radio" name="radio-choice-2" id="radio-choice-2" tabindex="3" value="choice-2" />
    </div>

	<div>
		<label for="select-choice">Select Dropdown Choice:</label>
		<select name="select-choice" id="select-choice">
			<option value="Choice 1">Choice 1</option>
			<option value="Choice 2">Choice 2</option>
			<option value="Choice 3">Choice 3</option>
		</select>
	</div>
	
	<div>
		<label for="textarea">Textarea:</label>
		<textarea cols="40" rows="8" name="textarea" id="textarea"></textarea>
	</div>
	
	<div>
	    <label for="checkbox">Checkbox:</label>
		<input type="checkbox" name="checkbox" id="checkbox" />
    </div>

	<div>
	    <input type="submit" value="Submit" />
    </div>
</form>
"""

html_minified = '<nav><ul><li><a href=#>Home</a></li><li><a href=#>About</a></li><li><a href=#>Clients</a></li><li><a href=#>Contact Us</a></li></ul></nav><form action=# method=post><div><label for=name>Text Input:</label><input name=name id=name value="" tabindex=1></div><div><h4>Radio Button Choice</h4><label for=radio-choice-1>Choice 1</label><input type=radio name=radio-choice-1 id=radio-choice-1 tabindex=2 value=choice-1><label for=radio-choice-2>Choice 2</label><input type=radio name=radio-choice-2 id=radio-choice-2 tabindex=3 value=choice-2></div><div><label for=select-choice>Select Dropdown Choice:</label><select name=select-choice id=select-choice><option value="Choice 1">Choice 1</option><option value="Choice 2">Choice 2</option><option value="Choice 3">Choice 3</option></select></div><div><label for=textarea>Textarea:</label><textarea cols=40 rows=8 name=textarea id=textarea></textarea></div><div><label for=checkbox>Checkbox:</label><input type=checkbox name=checkbox id=checkbox></div><div><input type=submit value=Submit></div></form>'


setupHexo = () ->
  hexo = new Hexo(process.cwd(), {silent: true})
  hexo.route.set 'some-html.html', html
  return hexo

test 'HTML minify test', (t) ->
  hexo = setupHexo()
  routes = hexo.route.routes

  minifier.call(hexo).then ->
    t.plan 2
    t.notEqual routes['some-html.html'].data.toString().length, html.length
    t.equal routes['some-html.html'].data.toString(), html_minified