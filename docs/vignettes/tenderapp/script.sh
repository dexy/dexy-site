### @export "prep"
ls
mv dexy1.json .dexy

### @export "query-categories"
dexy fcmd -alias tenderapp -cmd categories

### @export "dexy-setup"
dexy setup

### @export "screenshot-categories"
screenshot -url http://dexy.tenderapp.com/discussions -filename dexy--discussions.png

### @export "dexy"
dexy

### @export "screenshot-new-discussion"
export NEW_DISCUSSION_URL=`jazor output-long/new-discussion.md-tenderapp.json html_href`
echo $NEW_DISCUSSION_URL
screenshot -url $NEW_DISCUSSION_URL -filename dexy--new-discussion.png

### @export "comment"
NEW_DISCUSSION_HREF=`jazor output-long/new-discussion.md-tenderapp.json href`
echo $NEW_DISCUSSION_HREF
mv dexy2.json .dexy
echo "{ \"discussion\" : \"$NEW_DISCUSSION_HREF\" } " > tenderapp.json
cat tenderapp.json

dexy

screenshot -url $NEW_DISCUSSION_URL -filename dexy--new-comment.png

export TENDER_API_KEY=`jazor ~/.dexyapis 'tenderapp["api-key"]'`
dexy fcmd -alias tenderapp -cmd delete_discussion -discussionid $NEW_DISCUSSION_HREF

screenshot -url $NEW_DISCUSSION_URL -filename dexy--deleted.png

