// Custom
function _instanceof(left, right) {
  if (
    right != null &&
    typeof Symbol !== "undefined" &&
    right[Symbol.hasInstance]
  ) {
    return !!right[Symbol.hasInstance](left);
  } else {
    return left instanceof right;
  }
}

function _classCallCheck(instance, Constructor) {
  if (!_instanceof(instance, Constructor)) {
    throw new TypeError("Cannot call a class as a function");
  }
}

function _defineProperties(target, props) {
  for (var i = 0; i < props.length; i++) {
    var descriptor = props[i];
    descriptor.enumerable = descriptor.enumerable || false;
    descriptor.configurable = true;
    if ("value" in descriptor) descriptor.writable = true;
    Object.defineProperty(target, descriptor.key, descriptor);
  }
}

function _createClass(Constructor, protoProps, staticProps) {
  if (protoProps) _defineProperties(Constructor.prototype, protoProps);
  if (staticProps) _defineProperties(Constructor, staticProps);
  return Constructor;
}

// input custom renderer
var CustomInput = function () {
  function CustomInput(props) {
    _classCallCheck(this, CustomInput);

    var el = document.createElement('input');
    el.type = 'text';
    el.value = String(props.value);
    el.className = 'custom-input';
    this.el = el;
  }

  _createClass(CustomInput, [{
    key: "getElement",
    value: function getElement() {
      return this.el;
    }
  }, {
    key: "getValue",
    value: function getValue() {
      return this.el.value;
    }
  }, {
    key: "mounted",
    value: function mounted() {
      this.el.select();
    }
  }]);

  return CustomInput;
}();

// checkbox custom renderer
var CheckboxRenderer = function () {
  function CheckboxRenderer(props) {
    _classCallCheck(this, CheckboxRenderer);

    var grid = props.grid,
        rowKey = props.rowKey;
    var label = document.createElement('label');
    label.className = 'custom-checkbox-wrap';
    label.setAttribute('for', String(rowKey));
    var hiddenInput = document.createElement('input');
    hiddenInput.className = 'hidden-input';
    hiddenInput.id = String(rowKey);
    var customCheckbox = document.createElement('span');
    customCheckbox.className = 'custom-checkbox';
    label.appendChild(hiddenInput);
    label.appendChild(customCheckbox);
    hiddenInput.type = 'checkbox';
    hiddenInput.addEventListener('change', function () {
      if (hiddenInput.checked) {
        grid.check(rowKey);
      } else {
        grid.uncheck(rowKey);
      }
    });
    this.el = label;
    this.render(props);
  }

  _createClass(CheckboxRenderer, [{
    key: "getElement",
    value: function getElement() {
      return this.el;
    }
  }, {
    key: "render",
    value: function render(props) {
      var hiddenInput = this.el.querySelector('.hidden-input');
      var checked = Boolean(props.value);
      hiddenInput.checked = checked;
    }
  }]);

  return CheckboxRenderer;
}();