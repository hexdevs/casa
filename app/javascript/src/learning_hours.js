import { initializeDataTable } from '../datatable'
import $ from "jquery";
import DataTable from "datatables.net";
DataTable($);

$(() => {
  initializeDataTable('table#learning-hours')
})
