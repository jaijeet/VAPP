
import sys
from gi.repository import Gtk

class AST_Node:

    def __init__(self, uniqID, parent, text):
        self._uniqID = uniqID
        self._parent = parent
        self._children = []
        if parent is not None:
            parent._children.append(self)
        self._text = text

    def get_uniqID(self):
        return self._uniqID

    def get_parent(self):
        return self._parent

    def get_children(self):
        return self._children

    def get_text(self):
        return self._text

    def traverse(self):
        yield self
        for child in self._children:
            yield from child.traverse()


class VAPP_AST_Viewer(Gtk.Window):

    def __init__(self, file_name):
        self._file_name = file_name
        self._read_AST()
        self._create_model()
        self._init_gtk()

    def _read_AST(self):
        with open(self._file_name, 'r') as f:
            depth_map = {-1: None}
            for line_number, line in enumerate(f):
                idx = next(i for (i, ch) in enumerate(line) if ch not in ' |`-')
                depth, text = idx/4, line[idx:].strip()
                parent = depth_map[depth-1]
                depth_map[depth] = AST_Node(line_number + 1, parent, text)
        self._AST = depth_map[0]

    def _create_model(self):
        self._tree_store = Gtk.TreeStore(str, str)
        self._add_AST_to_tree_store(self._AST, None)

    def _add_AST_to_tree_store(self, node, parent):
        s1, s2 = node.get_text(), str(node.get_uniqID())
        it = self._tree_store.append(parent, [s1, s2])
        for child in node.get_children():
            self._add_AST_to_tree_store(child, it)

    def _init_gtk(self):

        Gtk.Window.__init__(self, title='VAPP AST Viewer')

        self._tree_view = Gtk.TreeView(self._tree_store)
        col_titles = ['AST Nodes ({})'.format(self._file_name), 'Line Numbers']
        for idx, s in enumerate(col_titles):
            # weird GTK "feature" that interprets single underscores to mean 
            # underline and double underscores to mean single underscores
            col_titles[idx] = s.replace('_', '__')
        for idx in range(2):
            cell_renderer = Gtk.CellRendererText()
            cell_renderer.set_alignment(idx, 0.5)
            col = Gtk.TreeViewColumn(col_titles[idx], cell_renderer, text=idx)
            col.set_expand(True if idx == 0 else False)
            col.set_resizable(True)
            self._tree_view.append_column(col)

        self._init_expansion_states()
        self._tree_view.connect('row-expanded', self._row_expanded)
        self._tree_view.connect('row-collapsed', self._row_collapsed)

        scroll_win = Gtk.ScrolledWindow()
        scroll_win.set_policy(Gtk.PolicyType.AUTOMATIC, 
                              Gtk.PolicyType.AUTOMATIC)
        scroll_win.add(self._tree_view)

        self.add(scroll_win)
        self.connect('delete-event', Gtk.main_quit)
        self.show_all()

        Gtk.main()

    def _init_expansion_states(self):
        self._is_expanded = {}
        for node in self._AST.traverse():
            self._is_expanded[node.get_uniqID()] = False

    def _node_uniqID_from_tree_iter(self, it):
        return int(self._tree_store[it][1])

    def _row_expanded(self, tree_view, tree_iter, tree_path):
        node_uniqID = self._node_uniqID_from_tree_iter(tree_iter)
        self._is_expanded[node_uniqID] = True
        num_children = self._tree_store.iter_n_children(tree_iter)
        for idx in range(num_children):
            child_iter = self._tree_store.iter_nth_child(tree_iter, idx)
            child_uniqID = self._node_uniqID_from_tree_iter(child_iter)
            if not self._is_expanded[child_uniqID]:
                continue
            child_path = self._tree_store.get_path(child_iter)
            self._tree_view.expand_row(child_path, False)

    def _row_collapsed(self, tree_view, tree_iter, tree_path):
        node_uniqID = self._node_uniqID_from_tree_iter(tree_iter)
        self._is_expanded[node_uniqID] = False


if __name__ == '__main__':
    AST_file_path = sys.argv[1]
    VAPP_AST_Viewer(AST_file_path)


