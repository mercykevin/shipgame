<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title><?php echo htmlspecialchars($title ? sprintf('%s - %s', $title, $moduleName) : $moduleName); ?></title>
<link rel="stylesheet" href="luadocx-style.css" type="text/css" />
<link rel="stylesheet" href="luadocx-style-monokai.css" type="text/css" />
<script src="luadocx-highlight.min.js"></script>
<script type="text/javascript" charset="utf-8">hljs.initHighlightingOnLoad();</script>
</head>
<body>
  <div id="container">

    <table id="main">
      <tr>
        <td id="navigation">

          <h2>Links</h2>
          <ul>
            <li><a href="<?php echo $indexFilename; ?>">Index</a></li>
          </ul>

          <h2>Modules</h2>
          <ul>
<?php
foreach ($modules as $module):
if ($module['moduleName'] == $moduleName):
?>
            <li><strong><?php echo htmlspecialchars($module['moduleName']); ?></strong></li>
<?php else: ?>
            <li><a href="<?php echo $module['outputFilename']; ?>"><?php echo htmlspecialchars($module['moduleName']); ?></a></li>
<?php
endif;
endforeach;
?>
          </ul>

        </td> <!-- navigation -->

        <td id="content">

          <h1>Module <code><?php echo htmlspecialchars($moduleName); ?></code></h1>

          <!-- BEGIN module doc -->

          <div id="module_doc">

<?php
foreach ($moduleDocs as $offset => $moduleDoc)
{
  $doc = makeCrossReferences(Markdown($moduleDoc), $modules) . "\n<br />\n\n";
  echo $doc;
}
?>

          </div>

          <!-- END module doc -->

<?php if (!empty($functions)): ?>

          <!--  BEGIN functions index -->

          <h2>Functions</h2>
          <table class="function_list">

<?php
$anchors = array();
foreach ($functions as $offset => $function):
  $fn = str_replace(array('.'), array('_'), $function['name']);
  if (isset($anchors[$fn]))
  {
    $anchors[$fn]++;
    $anchorName = sprintf('anchor_%s_%d', $fn, $anchors[$fn]);
  }
  else
  {
    $anchorName = sprintf('anchor_%s', $fn, $offset);
    $anchors[$fn] = 1;
  }
  $functions[$offset]['anchorName'] = $anchorName;
  $indent = (strpos($function['name'], ':')) ? '&nbsp;-&nbsp;&nbsp;' : '';
  $functionName = htmlspecialchars(sprintf('%s (%s)', $function['name'], $function['params']));
  $functionName = str_replace(' ', '&nbsp;', $functionName);
?>

            <tr>
              <td class="name" nowrap><?php echo $indent; ?><a href="#<?php echo $anchorName; ?>"><?php echo $functionName; ?></a></td>
              <td class="summary"><?php echo htmlspecialchars($function['description']); ?></td>
            </tr>

<?php endforeach; ?>

          </table>

          <!--  END functions index -->

          <br />
          <br />

          <!-- BEGIN functions details -->

          <h2>Functions</h2>
          <dl class="function">

<?php
foreach ($functions as $offset => $function):
  $fn = str_replace(array('.'), array('_'), $function['name']);
  $anchorName = $functions[$offset]['anchorName'];
  $indent = (strpos($function['name'], ':')) ? '-&nbsp;&nbsp;' : '';
  $class = (strpos($function['name'], ':')) ? 'member_method' : '';
  $functionName = htmlspecialchars(sprintf('%s (%s)', $function['name'], $function['params']));
?>

            <dt class="<?php echo $class; ?>">
              <?php echo $indent; ?><a name="<?php echo $anchorName; ?>"></a>
              <h3><?php echo $functionName; ?></h3>
            </dt>

            <dd class="<?php echo $class; ?>">

<?php
$doc = makeCrossReferences(Markdown($function['doc']), $modules);
echo $doc;
?>

            </dd>

<?php endforeach; ?>

          </dl>

          <!-- BEGIN functions details -->

<?php endif; // if (!empty($functions)): ?>

      </td> <!-- id="content" -->

      </tr>
    </table> <!-- id="main" -->

    <div id="about">
      <i>update: <?php echo htmlspecialchars(date('Y-m-d H:i:s')); ?>, generated by <a href="http://github.com/dualface/luadocx">luadocx <?php echo LUADOCX_VERSION; ?></a></i>
    </div> <!-- id="about" -->

  </div> <!-- id="container" -->

</body>
</html>
