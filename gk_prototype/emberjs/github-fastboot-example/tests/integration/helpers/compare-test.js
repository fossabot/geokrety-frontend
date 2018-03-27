import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import hbs from 'htmlbars-inline-precompile';

module('Integration | Helper | compare', function(hooks) {
  setupRenderingTest(hooks);

  // Replace this with your real tests.
  test('it renders', async function(assert) {
    this.set('inputValue', 1234);

    await render(hbs`{{compare inputValue '>' 1230}}`);

    assert.equal(this.element.textContent.trim(), 'true');

    await render(hbs`{{compare inputValue '<' 1230}}`);

    assert.equal(this.element.textContent.trim(), 'false');

    await render(hbs`{{compare inputValue '==' 1234}}`);

    assert.equal(this.element.textContent.trim(), 'true');
  });
});
