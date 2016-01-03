/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
    config.language = 'zh-cn'; //配置语言   
    config.uiColor = '#FFF'; //背景颜色   
    config.width = 'auto'; //宽度   
    config.height = '300px'; //高度   
    config.skin = 'v2'; //界面v2,kama,office2003   
    config.toolbar = 'Full'; //工具栏风格Full,Basic 
    config.font_names='宋体/宋体;黑体/黑体;仿宋/仿宋_GB2312;楷体/楷体_GB2312;隶书/隶书;幼圆/幼圆;'+ config.font_names;//将中文字体加入到字体列表    
};
