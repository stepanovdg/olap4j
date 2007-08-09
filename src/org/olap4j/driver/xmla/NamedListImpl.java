/*
// This software is subject to the terms of the Common Public License
// Agreement, available at the following URL:
// http://www.opensource.org/licenses/cpl.html.
// Copyright (C) 2007-2007 Julian Hyde
// All Rights Reserved.
// You must accept the terms of that agreement to use this software.
*/
package org.olap4j.driver.xmla;

import java.util.ArrayList;

import org.olap4j.metadata.NamedList;

/**
 * Implementation of {@link org.olap4j.metadata.NamedList} which uses
 * {@link java.util.ArrayList} for storage and assumes that elements implement
 * the {@link Named} interface.
 *
 * @author jhyde
 * @version $Id: NamedListImpl.java 20 2007-06-10 23:09:28Z jhyde $
 * @since May 23, 2007
 */
class NamedListImpl<T extends Named>
    extends ArrayList<T>
    implements NamedList<T> {

    public T get(String name) {
        for (T t : this) {
            if (t.getName().equals(name)) {
                return t;
            }
        }
        return null;
    }

    public int indexOfName(String name) {
        for (int i = 0; i < size(); ++i) {
            T t = get(i);
            if (t.getName().equals(name)) {
                return i;
            }
        }
        return -1;
    }
}

// End NamedListImpl.java