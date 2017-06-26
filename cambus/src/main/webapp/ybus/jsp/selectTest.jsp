<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="kr">
	<head>
	<meta charset="UTF-8">
	<title>http://www.blueb.co.kr</title>

<style type="text/css">
*, *:before, *:after {
  box-sizing: border-box;
}

html,
body {
  height: 100%;
}

body {
  background: #ddd;
  display: -webkit-box;
  display: -webkit-flex;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-pack: center;
  -webkit-justify-content: center;
      -ms-flex-pack: center;
          justify-content: center;
  -webkit-box-align: center;
  -webkit-align-items: center;
      -ms-flex-align: center;
          align-items: center;
  height: inherit;
}

.hide {
  clip: rect(0 0 0 0);
  height: 1px;
  margin: -1px;
  padding: 0;
  position: absolute;
  width: 1px;
}

.toggleBtn {
  display: block;
  position: relative;
  cursor: pointer;
  outline: none;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  padding: 2px;
  width: 110.4px;
  height: 48px;
  border-radius: 24px;
  background: #f3f3f3;
  -webkit-transition: box-shadow 0.4s;
  transition: box-shadow 0.4s;
}
.toggleBtn:after {
  display: block;
  position: absolute;
  content: "";
  top: 0;
  left: 0;
  bottom: 0;
  margin: auto 0;
  width: 60px;
  height: 60px;
  background: #fff;
  border-radius: 50%;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
  -webkit-transition: background 0.4s, left 0.4s, height 0.2s, width 0.2s;
  transition: background 0.4s, left 0.4s, height 0.2s, width 0.2s;
}

input:checked + .toggleBtn {
  box-shadow: inset 0 0 0 48px #8bb1e3;
}

.toggleBtn:active:after,
input:checked + label:active:after {
  height: 43.63636px;
  width: 57.6px;
}

input:checked + .toggleBtn:after {
  left: calc(100% - 60px);
  background: #1663c7;
}

</style>
</head>
<body>


<input id="toggle" type="checkbox" class="hide"/>
<label class="toggleBtn" for="toggle"><span class="hide">Label Title</span></label>

</script>
</body>
</html>
